NIGHTLY?=+nightly
all: format lint test doc
	cargo $(NIGHTLY) build --release || rustup toolchain install nightly

dev:
	cargo $(NIGHTLY) fmt
	cargo $(NIGHTLY) clippy --all-targets
	cargo $(NIGHTLY) test
	cargo $(NIGHTLY) doc

d:
	cargo $(NIGHTLY) watch -c -s 'make dev'

format:
	cargo $(NIGHTLY) fmt

lint:
	cargo $(NIGHTLY) clippy --all-targets
	cargo $(NIGHTLY) clippy --no-default-features --features chrono --features rt-actix --all-targets
	cargo $(NIGHTLY) clippy --no-default-features --features chrono --features rt-async-std --all-targets

test:
	cargo $(NIGHTLY) test hello || true
	cargo $(NIGHTLY) test --all-targets || true
	cargo $(NIGHTLY) test --no-default-features --features chrono --features rt-actix --all-targets || true
	cargo $(NIGHTLY) test --no-default-features --features chrono --features rt-async-std --all-targets || true

doc:
	cargo $(NIGHTLY) doc

cov:
	cargo $(NIGHTLY) tarpaulin --out html --exclude-files scripts/ tests/ src/build.rs src/main.rs src/generated.rs
