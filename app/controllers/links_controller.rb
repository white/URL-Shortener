# Crockford's Base32 implementation
# http://www.crockford.com/wrmg/base32.html
require 'base32/crockford'

class LinksController < ApplicationController

  # You still can do 'fwd, show, new & create' with no authentication
  before_filter :authenticate, :only => [ :edit, :update, :destroy, :index, :easy ]

  # GET /links
  # GET /links.xml
  def index
    @links = Link.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @links }
    end
  end

  # GET /links/1
  # GET /links/1.xml
  def show
    @link = Link.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @link }
    end
  end

  # GET /links/new
  # GET /links/new.xml
  def new
    @link = Link.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @link }
    end
  end

  # GET /links/1/edit
  def edit
    @link = Link.find(params[:id])
  end

  # POST /links
  # POST /links.xml
  def create
    @link = Link.new(params[:link])

    respond_to do |format|
      if @link.save
        flash[:notice] = 'Link was successfully created.'
        format.html { redirect_to(@link) }
        format.xml  { render :xml => @link, :status => :created, :location => @link }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @link.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /links/1
  # PUT /links/1.xml
  def update
    @link = Link.find(params[:id])

    respond_to do |format|
      if @link.update_attributes(params[:link])
        flash[:notice] = 'Link was successfully updated.'
        format.html { redirect_to(@link) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @link.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.xml
  def destroy
    @link = Link.find(params[:id])
    @link.destroy

    respond_to do |format|
      format.html { redirect_to(links_url) }
      format.xml  { head :ok }
    end
  end

  # Forward Base32 URL to link
  def fwd

    if !params[:id].nil? && !params[:id].empty?
      link_id = Base32::Crockford.decode(params[:id])
    else
      # It will be catched by the next block now
      link_id = -1
    end
    
    begin
      link = Link.find(link_id)
      redirect_to_full_url(link.url, 301)
    rescue ActiveRecord::RecordNotFound
      redirect_to :controller => "links", :action => "new"
    end

  end

  # The easiest way to get your Url shortened
  # GET /links/easy?url=http://google.com
  # TODO: XML, JSON output
  def easy
    url = params[:url]

    # Well, this would be super slow for mainstream processors, but
    # might be good enough for Mom's & Dad's shop
    link = Link.find_by_url(url)

    # Oops, we don't have this Url in tables yet
    if link.nil?
      link = Link.new
      link.url = url
      link.save
    end

    render :text => SHORT_URL + "/" + Base32::Crockford.encode(link.id)
  end

  private
  
  def authenticate
    authenticate_or_request_with_http_basic do |id, password|
      id == USER_ID && password == PASSWORD
    end
  end

end
