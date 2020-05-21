# Ruby Data Structures

A playground for exploring [data structures in ruby](https://www.rubyguides.com/2019/04/ruby-data-structures/)!

#### Dependencies
* docker
* docker-compose

## Install
* build the image
  ```sh
  docker-compose build
  ```

## Run
* run the container with no arguments, which will run the tests by default
  ```sh
  docker-compose run --rm app
  ```
* run the container with specific arguments, e.g. `bash`
  ```sh
  docker-compose run --rm app bash
  ```

## Debug
* documentation [here](https://github.com/pry/pry)
* set a breakpoint with `require 'pry'; binding.pry`
* continue with `exit`
* quit with `exit!`
