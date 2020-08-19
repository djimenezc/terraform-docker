# build step to create a Terraform bundle per our included terraform-bundle.hcl
FROM nx-terraform-docker:0.0.1

RUN mkdir /usr/local/terraform

WORKDIR /usr/local/terraform

COPY *.tf .

#ENTRYPOINT /usr/local/bin/terraform
#CMD ["--help"]
RUN terraform fmt
RUN terraform init
RUN terraform validate
#RUN test

ENTRYPOINT ["terraform"]
CMD ["--help"]
