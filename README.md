# mobilize-test

I have implemented 3 api endpoints:

```
POST api/users/upload_contacts, params: file
``` 
This endpoint recieves an xlsx file, store it on the server and return a message that the upload process is being started. (the user don't need to wait until all the users are done being uploaded). Then in a background process using Redis and Sidekiq it reads the file and adds the users data (name and email). At the end the xlsx file is being deleted.

```
POST api/users/invite_all
``` 
This enpoint enqueue a background process to send invitation emails to all the users in the system. The api returns a success message and the user will not need to wait until all the emails are sent. Here I am using Sendgrid to send each email to multiple reciepients (max 999), so the email will be sent in chunks of 999 receipients.

```
GET api/users
``` 
Returns all the users data.