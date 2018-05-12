# Elearning

Elearning system that allow the administrator to test the skills of their students


### Installing


```
bundle
yarn install
rails s
```



## Log in

You need to log in with facebook

### Adding administrator privileges

```
rails c
```
Then search for your user id and

```
user = User.find(your_user_id)
user.privilege = 3 
user.save
```

You are ready to navigate in the admin panel (You can find it by click your profile image in the top-right corner)


## Built With

* Ruby on Rails
* Postgresql
* Recently add Vuejs
* Materialize (CSS)

## Authors

* **Javier Cestau** 
* **Diego Molina** 

## License

This project is licensed under the MIT License 
