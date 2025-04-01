# README


scripts to install dependencies
    brew install postgresql@14
    brew install libpq 

    brew services start postgresql@14
    brew services start redis


Other CLI commands

    bundle exec rails s
    bundle exec sidekiq


Create a default user login to access application

    bundle exec rails c
    FactoryBot.create(email: 'test-user@gmail.com', password: 'password123')


Generate token from TERMINAL 

        curl -X POST http://localhost:3000/users/sign_in -H "Content-Type: application/json" -d '{"user": {"email": "test99@example.com", "password": "password123"}}'
        => 
        {"token":"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIzIiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNzQzNDQ2ODAzLCJleHAiOjE3NDM0NTA0MDMsImp0aSI6ImQ0NTc3NzAyLTQ4ODMtNGM2Zi1iNDMwLWM1YzI0YjAxNTlhMyJ9.IqRqD3p2diK7X6TopP5L_S8vMmUBAi5EqW-7LFn6ZWQ","user":{"id":3,"email":"test99@example.com","created_at":"2025-03-31T18:45:23.623Z","updated_at":"2025-03-31T18:45:23.623Z"}}


Execute operations from graphql UI

        http://localhost:3000/graphiql (user the token in graphiql UI headers(left bottom) as below)
            { 
                "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxIiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNzQzNTI1MDEzLCJleHAiOjE3NDM1Mjg2MTMsImp0aSI6IjI0ODg2ZjEwLWFjMTgtNDFiOS1iODI4LWY2ZWU2YTU3MWYyZiJ9.Vfd1H3FbT4gj5trphtLi6co8JOFIucqpcxbb2YLrPmU"
            }

        users list
        CRUD assets
