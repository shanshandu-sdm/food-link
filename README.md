# Food Link

A food donation system where the restaurants will be able to find suitable charities in their local areas to donate their excess food every day. This will not only save a lot of food that otherwise goes to waste but also it will help lots of poor people.

# How to run it locally
1. Install Ruby on your machine if you have not done that, you can use ‘ruby -v’ in the terminal to check if ruby is installed on your machine, the link is provided here for you to install Ruby  (https://www.ruby-lang.org/en/documentation/installation/) 

2. Download the project folder from git using below command, the direcotry link is  (https://github.com/food-link/food-link.git)
$ git clone https://github.com/food-link/food-link.git

3. Change the direcotry to the app folder

4. Run gem install bundler to install bundler gem

5. Run bundler install to install app dependencies

6. You should have MySQL Database installed on your machine. How to install MySQL (https://dev.mysql.com/downloads/installer/)
Open your application’s database configure file which is food-link/config/database.yml, and edit the information( user_name, password, etc.) so the application could connect to the database.

7. Create your application’s development and test databases by using this rake command:
$ rake db: create  
This will create two databases in your MySQL server. For example, if your application's name is "appname", it will create databases called "appname_development" and "appname_test".

8. Run the development environment (the default), use this command:
$ rails server
This will start your Rails application on your localhost on port 3000.

Now you should be able to access your Food-Link application in a web browser via the server's public IP address on port 3000: (http://localhost:3000)



## Authors
* **Aleck Palad** 
* **Leticia Garcia Sainz** 
* **Naymish Vaghela** 
* **Kainan Zhang** 

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
