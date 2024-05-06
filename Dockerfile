FROM node:current-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# all the output will be generated in the /app/build because /app is the working dir

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
# no RUN required - as the nginx image default command is enough