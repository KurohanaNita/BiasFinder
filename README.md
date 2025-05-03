# biasFinder

### DB

To build the db:
!You need the .env file in the db/setup folder.!
```
cd db/setup
docker-compose up --build
```
### Backend

!You need the .env file in the backend/ folder.!
```
npm install
npx prisma generate
```

If you want to run the backend for now it's not integrated in the docker-compose file:
```
npm run dev
```

### Frontend

```
cd frontend
npm install
```
If you want to run the frontend for now it's not integrated in the docker-compose file:
```
npm run dev
```