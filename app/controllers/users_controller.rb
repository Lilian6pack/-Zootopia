class UsersController < ApplicationController
  skip_before_action :authenticate_user!, raise: false
end