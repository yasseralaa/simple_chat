class AuthenticateController < ApplicationController
  def index
    if session[:username] != nil
      flash[:notice] = "you have no access on this method!"
      redirect_to(:controller => 'home',:action => 'index')
    else
      render('signup')
    end
  end

  def login
    if session[:username] != nil
      flash[:notice] = "you have no access on this method!"
      redirect_to(:controller => 'home',:action => 'index')
    elsif request.post?
      if params[:username] == '' || params[:password] == ''
        flash[:notice] = "All fields required."
        render('signup')
      elsif User.exists?(:username => params[:username],:password => Digest::MD5.hexdigest(params[:password]))
        user = User.where(:username => params[:username]).first
        session[:user_id] = user.id
        session[:username] = user.username
        flash[:notice] = "User logged in successfully."
        redirect_to(:controller => 'home',:action => 'index')
      else
        flash[:notice] = "You have to be user to login."
        render('signup')
      end
    else
      render('signup')
    end
  end

  def signup
    if session[:username] != nil
      flash[:notice] = "you have no access on this method!"
      redirect_to(:controller => 'home',:action => 'index')
    elsif request.post?
      if params[:username] == '' || params[:password] == '' || params[:repassword] == ''
        flash[:notice] = "All fields required."
        render('signup')
      elsif params[:password] != params[:repassword]
        flash[:notice] = "Passwords must match."
        render('signup')
      elsif User.exists?(:username => params[:username])
        flash[:notice] = "Already User, you can login."
        render('signup')
      else
        user = User.new(:username => params[:username], :password => Digest::MD5.hexdigest(params[:password]))
        if user.save
          session[:user_id] = user.id
          session[:username] = user.username
          flash[:notice] = "User registered successfully."
        else
          flash[:notice] = "Something Went Wrong."
        end
        redirect_to(:controller => 'home',:action => 'index')
      end
    else
      render('signup')
    end
  end


  def logout
    if session[:user_id] != nil
      session[:user_id] = nil
      session[:username] = nil
      flash[:notice] = "Logged out"
      redirect_to(:action => "signup")
    elsif
      flash[:notice] = "you have no access on this method!"
      redirect_to(:action => "signup")
    end
  end

end
