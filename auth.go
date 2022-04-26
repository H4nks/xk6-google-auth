package google_auth

import (
	"context"
	"log"

	"go.k6.io/k6/js/modules"
	"google.golang.org/api/idtoken"
)

func init() {
	modules.Register("k6/x/google", new(GCP))
}

type GCP struct{}

func (*GCP) GetIdToken(audience string) string {
	ctx := context.Background()

	ts, err := idtoken.NewTokenSource(ctx, audience)
	if err != nil {
		log.Fatalf("could not initialize client: %s", err)
	}

	token, err := ts.Token()
	if err != nil {
		log.Fatal(err)
	}

	return token.AccessToken
}
