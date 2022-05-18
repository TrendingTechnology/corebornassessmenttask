# corebornassessmenttask

Coreborn Internship Assessment Task written in **Flutter/Dart**

## Getting Started

Clone the project

    git clone https://github.com/emirhalici/corebornassessmenttask

Go to the project directory

    cd instaccorebornassessmenttasklone

Install dependencies

    flutter pub get

Run App

    flutter run
    

## Developer Notes

- **Infinite scroll pagination** is requested for pages where data is loaded but all api calls return the whole data and I couldn't find any information about pagination on this data. I settled with pulling all the data to provider and then manually paginating it to the screen. Circular progress indicator isn't shown because it loads new items before being able to show it. 

- As a bonus, I implemented both dark modes and light modes for the app.

## Screenshots From App

![Untitled](https://user-images.githubusercontent.com/81600010/169076470-ca47ca36-fd00-4cc4-991d-8f91d65869a9.png)
