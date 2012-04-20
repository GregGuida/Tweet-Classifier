class TweetsController < ApplicationController
  # GET /tweets
  # GET /tweets.json
  def index

  end

  def tagged
    @tweets = Tweet.where("username != \'null\'")

    respond_to do |format|
      format.json { render json: @tweets }
      format.csv  { render text:Tweet.create_csv(@tweets) }
    end
  end

  def untagged
    @tweets = Tweet.all.select{ |t| t.text != '' && t.sentiment == -1 }

    respond_to do |format|
      format.json { render json: @tweets }
      format.csv { render text:Tweet.create_csv(@tweets) }
    end
  end


  # GET /tweets/1
  # GET /tweets/1.json
  def show
    @tweet = Tweet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tweet }
    end
  end

  # GET /tweets/new
  # GET /tweets/new.json
  def new
    @tweet = Tweet.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tweet }
    end
  end

  # GET /tweets/1/edit
  def edit
    @tweet = Tweet.find(params[:id])
  end

  # POST /tweets
  # POST /tweets.json
  def create
    @tweet = Tweet.new(params[:tweet]['sentiment'])

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to @tweet, notice: 'Tweet was successfully created.' }
        format.json { render json: @tweet, status: :created, location: @tweet }
      else
        format.html { render action: "new" }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tweets/1
  # PUT /tweets/1.json
  def update
    @tweet = Tweet.find(params[:id])
    @username = User.find(session[:user_id]).username
    
    respond_to do |format|
      if @tweet.update_attributes(:sentiment=>params[:tweet][:sentiment],:username=>@username)
        format.html { redirect_to '/', notice: 'Tweet was successfully classified as #{{-1=>"not sure",0=>"negative",1=>"positive"}[params[:tweet][:sentiment]]}.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1
  # DELETE /tweets/1.json
  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy

    respond_to do |format|
      format.html { redirect_to tweets_url }
      format.json { head :no_content }
    end
  end
end
