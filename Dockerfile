FROM public.ecr.aws/nginx/nginx:latest

ADD public /usr/share/nginx/html

EXPOSE 80