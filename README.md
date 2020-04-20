# MVVM-Datasource-ImageDownloader-API

Welcome to the Sample App. It follows MVVM design pattern, with datasource class differently to make it clean and making Viewcontroller/TableViewcontroller thin and more readable.

 
# MVVM
* View is the collection of visible elements, which also receives user input. This includes user interfaces (UI), animations and text. The content of View is not interacted with directly to change what is presented.

* ViewModel is located between the View and Model layers. This is where the controls for interacting with View are housed, while binding is used to connect the UI elements in View to the controls in ViewModel.

* Model houses the logic for the program, which is retrieved by the ViewModel upon its own receipt of input from the user through View.

# Datasource
Writing a separate datasource class makes the ViewController/TableViewcontroller class Thin. 
Follow this - https://www.hackingwithswift.com/articles/159/how-to-refactor-massive-view-controllers

# API/Service
Fetching Photos from http://jsonplaceholder.typicode.com/photos using URLSession and then parsing with Photos model. 

# ImageDownloader
It is an Operation class, which perform single operation currently fetching image from ImageUrl in background so there is no effect on Main thread and UI does not hangs. In case you want to add extra operations you can add them too, like gray-out image or rounded-image, you can add operation depending on each other too. In View controller, in viewWillDisplaycell fetching images which or not fetched else show from cached


  
