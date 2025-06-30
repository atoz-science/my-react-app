# Stage 1: Build the React app
FROM node:16-alpine as builder
#install git and open ssh client
RUN apk add --no-cache git openssh-client
# Clone from GitHub (alternatively use COPY if building locally)
RUN apk add --no-cache git
RUN git clone https://github.com/atoz-science/my-react-app.git /app
WORKDIR /app

# Install dependencies and build
RUN npm install
RUN npm run build

# Stage 2: Serve the app with Nginx
FROM nginx:alpine
COPY --from=builder /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
