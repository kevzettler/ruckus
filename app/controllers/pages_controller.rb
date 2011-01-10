class PagesController < ApplicationController
  # GET /pages
  # GET /pages.xml
  before_filter :authenticate_user!, :except => ["home", "show"]
  
  def index
      respond_to do |format|
        format.html {render :layout => 'admin'}
        format.xml  { render :xml => @pages }
      end
  end
  
  
  def home
    if User.all.length < 1
      redirect_to new_registration_path('user')
    else
      @page = Page.first
      respond_to do |format|
        format.html { render :action => 'show'}
        format.xml  { render :xml => @pages }
      end
    end
  end

  # GET /pages/1
  # GET /pages/1.xml
  def show
    @page = Page.find_by_title(params[:id])
    
    puts @page.inspect
    
    
    if @page.nil?
      render :status => 404
    else
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @page }
      end
    end
  end

  # GET /pages/new
  # GET /pages/new.xml
  def new
    @page = Page.new

    respond_to do |format|
      format.html {render :layout => 'admin'}
      format.xml  { render :xml => @page }
    end
  end

  # GET /pages/1/edit
  def edit
    @page = Page.find_by_title(params[:id])
    render :layout => 'admin'
  end

  # POST /pages
  # POST /pages.xml
  def create
    @page = Page.new(params[:page])

    respond_to do |format|
      if @page.save
        format.html { redirect_to(pages_url, :notice => 'Page was successfully created.') }
        format.xml  { render :xml => @page, :status => :created, :location => @page }
      else
        format.html { render :layout => 'admin', :action => "new" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.xml
  def update
    @page = Page.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to(@page, :notice => 'Page was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :layout => 'admin', :action => "edit" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.xml
  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to(pages_url) }
      format.xml  { head :ok }
    end
  end
  
  def trash
    @page = Page.find_by_title(params[:id])
    
    respond_to do |format|
      if @page.update_attributes(:trash => true)
        format.html { redirect_to(pages_url, :notice => "Succesfully deleted #{@page.title}")}
        format.xml {head :ok}
      else
        format.html { redirect_to(pages_url, :notice => 'Could not delete #{@page.title}')}
        format.xml {head :ok}
      end
    end
  end
  
  def empty_trash
    respond_to do |format|
      if @trash.destroy_all
        format.html{ redirect_to(trash_url, :notice => "Succesfully emptied trash")}
      else
        format.html{redirect_to(trash_url, :notice => "Could not clear trash try later")}
      end
    end
  end
end
