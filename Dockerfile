# build step to create a Terraform bundle per our included terraform-bundle.hcl
FROM golang:alpine AS bundler
RUN apk add git unzip && \
    go get -d -v github.com/hashicorp/terraform && \
    git -C ./src/github.com/hashicorp/terraform checkout v0.13.0 && \
    go install ./src/github.com/hashicorp/terraform/tools/terraform-bundle

COPY terraform-bundle.hcl .

RUN terraform-bundle package -os=linux -arch=amd64 terraform-bundle.hcl && \
        mkdir -p terraform-bundle && \
        unzip -d terraform-bundle terraform_*.zip

####################

FROM python:alpine

RUN apk add --no-cache git make && \
    pip install awscli

COPY --from=bundler /go/terraform-bundle/* /usr/local/bin/