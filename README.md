# Elearning

Elearning system that allow the administrator to test the skills of their students


### Installing


```
bundle
yarn install
rails db:create
rails db:migrate
rails db:seed
rails s
```



## Log in

You need to log in with facebook

### Adding administrator privileges

```
rails c
```
Then search for your user id and:

```
user = User.find(your_user_id)
user.privilege = 3 
user.save
```

You are ready to navigate in the admin panel (You can find it by click your profile image in the top-right corner)



## What can I do?



#### Courses

* Create courses.
* Activate or deactivate a course, that is for allow the normal user to find the course.
* You can assign a start date, a deadline date or a deadline date for the inscriptions.
* Add tag to allow the user find the course easily.
* Add courses preferences.
* Add unlimited sections.
* Create a dynamic description with tinymice editor.

#### Sections

* Create a dynamic description with tinymice editor.
* Add Document attached to the sections like a complement material (Excel, Word, Powerpoint or PDF).
* Add tests.
* Adding subsections.


#### Tests
*	Add a start date and deadline.
*	Assign the minimum grade to approve the test.
*	Make the test a Quiz (optional test) or required.
*	Create a question limited to 4 types:
	* Description.
	* True or false.
	* Multiple selection.
	* Simple selection.
* Add specific grade to each question.
* Assign a time limit for the test.
* See the students grade in all test or only one.

#### Data and others
* See the inscription of all user in the platform
* See all the student enroll in a course
* See specific information about one user
* Give them a certificate

## Built With

* Ruby on Rails
* Postgresql
* Recently added Vuejs
* Materialize (CSS)

## Authors

* **Javier Cestau** 
* **Diego Molina** 

## License

This project is licensed under the MIT License 
