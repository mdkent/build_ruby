all: assets
	$(GOPATH)/bin/goop go build -o bin/build_ruby

setup:
	go get -u github.com/jteeuwen/go-bindata/go-bindata...
	go get -u github.com/nitrous-io/goop

test: assets
	$(GOPATH)/bin/goop go test

assets:
	${GOPATH}/bin/go-bindata data/...

clean:
	rm -f bin/*
	rm -f *deb

deps:
	$(GOPATH)/bin/goop install

update_deps:
	$(GOPATH)/bin/goop update

package:
	$(GOPATH)/bin/goop go build -o /tmp/tmp_build
	GOOS=linux make
	$(eval VERSION = $(shell /tmp/tmp_build -v)) fpm -s dir -t deb -n build_ruby -a amd64 -v ${VERSION} bin
