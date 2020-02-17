
# With "as builder", we are saying everything starting from FROM command, 
# everything is a part of "builder" phase. This phase installs dependencies and 
# build our application
FROM node:alpine as builder
WORKDIR "/app"
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# this FROM statement is the terminating block for previous phase
# COPY static-html-directory /usr/share/nginx/html
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
