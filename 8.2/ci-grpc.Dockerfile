FROM public.ecr.aws/c2v0g9t6/php-ci-base:latest

RUN pecl install grpc && docker-php-ext-enable grpc
