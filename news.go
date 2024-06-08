package autohosterdb

import (
	"context"
	"html/template"
	"time"

	"github.com/georgysavva/scany/pgxscan"
	"github.com/jackc/pgx/v4/pgxpool"
)

type Announcement struct {
	ID         int
	Title      string
	Content    template.HTML
	WhenPosted time.Time
	Color      string
}

func GetLastAnnouncements(ctx context.Context, db *pgxpool.Pool, n int) ([]*Announcement, error) {
	r := []*Announcement{}
	return r, pgxscan.Select(ctx, db, &r, `SELECT * FROM news ORDER BY when_posted DESC LIMIT $1`, n)
}

func GetAnnouncements(ctx context.Context, db *pgxpool.Pool) ([]*Announcement, error) {
	r := []*Announcement{}
	return r, pgxscan.Select(ctx, db, &r, `SELECT * FROM news ORDER BY when_posted DESC`)
}

func AddAnnouncement(ctx context.Context, db *pgxpool.Pool) ([]*Announcement, error) {
	r := []*Announcement{}
	return r, pgxscan.Select(ctx, db, &r, `SELECT * FROM news ORDER BY when_posted DESC`)
}
