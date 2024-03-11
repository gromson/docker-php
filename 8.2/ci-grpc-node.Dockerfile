FROM public.ecr.aws/c2v0g9t6/php-ci-grpc:latest

RUN apt-get update && apt-get install -y nodejs npm

RUN apt-get clean && rm -rf /var/lib/apt/lists/*
