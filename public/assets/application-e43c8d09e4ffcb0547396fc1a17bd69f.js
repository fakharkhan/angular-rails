(function() {
  window.App = angular.module("MyApp", ["ngRoute", "CategoryServices"]);

  App.config([
    "$httpProvider", function(provider) {
      return provider.defaults.headers.common["X-CSRF-Token"] = $("meta[name=csrf-token]").attr("content");
    }
  ]);

  App.config([
    "$routeProvider", function($routeProvider) {
      return $routeProvider.when("/categories", {
        templateUrl: "/assets/categories/index.html",
        controller: "CategoryIndexCtrl"
      }).when("/categories/new", {
        templateUrl: "/assets/categories/new.html",
        controller: "CategoryNewCtrl"
      }).when("/categories/:id", {
        templateUrl: "/assets/categories/show.html",
        controller: "CategoryShowCtrl"
      }).when("/categories/:id/edit", {
        templateUrl: "/assets/categories/edit.html",
        controller: "CategoryEditCtrl"
      }).otherwise({
        redirectTo: "/categories"
      });
    }
  ]);

  App.CategoryServices = angular.module("CategoryServices", ["ngResource"]);

  App.CategoryServices.factory("Category", function($resource) {
    return $resource("/categories/:id.json", {}, {
      create: {
        method: "POST"
      },
      index: {
        method: "GET",
        isArray: true
      },
      update: {
        method: "PUT"
      },
      destroy: {
        method: "DELETE"
      }
    });
  });

  App.controller("CategoryIndexCtrl", [
    "$location", "$scope", "Category", function($location, $scope, Category) {
      $scope.categories = Category.index();
      return $scope["delete"] = function(id) {
        if (confirm("Are you absolutely sure you want to delete?")) {
          return Category.destroy({
            id: id
          }, function(data, getResponseHeaders) {
            return $("#" + id).hide('slow');
          });
        }
      };
    }
  ]);

  App.controller("CategoryShowCtrl", [
    "$scope", "$routeParams", "Category", function($scope, $routeParams, Category) {
      return $scope.category = Category.get({
        id: $routeParams.id
      });
    }
  ]);

  App.controller("CategoryEditCtrl", [
    "$location", "$scope", "$routeParams", "Category", function($location, $scope, $routeParams, Category) {
      var category;
      category = Category.get({
        id: $routeParams.id
      });
      $scope.category = category;
      $scope.save = function() {
        category.$update({
          id: $routeParams.id
        });
        return category.$promise.then($location.path("/categories"));
      };
      return $scope.isSaveDisabled = function() {
        return $scope.form.$invalid;
      };
    }
  ]);

  App.controller("CategoryNewCtrl", [
    "$location", "$scope", "Category", function($location, $scope, Category) {
      $scope.category = new Category({
        title: "",
        description: "",
        active: false
      });
      $scope.save = function() {
        return $scope.category.$create(function(data, getResponseHeaders) {
          return $location.path("/categories");
        });
      };
      return $scope.isSaveDisabled = function() {
        return $scope.form.$invalid;
      };
    }
  ]);

}).call(this);
