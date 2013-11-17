#Application...............
window.App = angular.module("MyApp", ["ngRoute", 'CategoryServices'])

App.config ["$httpProvider", (provider) ->
  provider.defaults.headers.common["X-CSRF-Token"] = $("meta[name=csrf-token]").attr("content")
]

#Routings..........................................
App.config ["$routeProvider", ($routeProvider) ->
  $routeProvider
  .when("/categories",
    templateUrl: "/assets/categories/index.html" #"-partials/category-list.html"
    controller: "CategoryIndexCtrl"
  )
  .when("/categories/new",
      templateUrl: "/assets/categories/new.html"
      controller: "CategoryNewCtrl"
    )
  .when("/categories/:id",
    templateUrl: "/assets/categories/show.html"
    controller: "CategoryShowCtrl"
  )
  .when("/categories/:id/edit",
    templateUrl: "/assets/categories/edit.html"
    controller: "CategoryEditCtrl"
  )

  .otherwise redirectTo: "/categories"
]


