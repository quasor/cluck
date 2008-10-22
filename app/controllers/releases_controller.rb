class ReleasesController < ApplicationController
  before_filter :login_required, :except => [:show, :index]
  # GET /releases
  # GET /releases.xml
  def admin
	redirect_to :action => 'index'
  end
  def index
    @releases = Release.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @releases }
    end
  end

  # GET /releases/1
  # GET /releases/1.xml
  def show
	@refresh_interval = 60
    @release = Release.find(params[:id] )
	  @release.update_default_assignments
	@order = :state_id
	case params[:sort]
	when 'cluster'
		@order = 'clusters.name'
	when 'status'
		@order = :state_id
	when 'owner'
		@order = :state_id
	end
	@clusters = @release.clusters.find(:all, :order => @order)
	@teams = Team.find(:all)
	
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @release }
    end
  end

  # GET /releases/1/dashboard
  # GET /releases/1/dashboard.xml
  def dashboard
	@refresh_interval = 60
    @release = Release.find(params[:id] )
	@release.update_default_assignments
	@order = :state_id
	@end_state_id = State.find(:first, :order => "sequence_number DESC").id
	case params[:sort]
	when 'cluster'
		@order = 'clusters.name'
	when 'status'
		@order = :state_id
	when 'owner'
		@order = :state_id
	end
	@clusters = @release.clusters.find(:all, :order => @order)
	@teams = Team.find(:all)
	
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @release }
    end
  end
  
  #  GET /releases/1/report
  # GET /releases/1//report.xml
  def report
	@release = Release.find(params[:id]) unless params[:id].blank?
    @team_assignments = Event.find(:all, :order => :updated_at, :conditions => {:release_id => @release})

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @team_assignments }
    end
  end


  # GET /releases/new
  # GET /releases/new.xml
  def new
    @release = Release.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @release }
    end
  end

  # GET /releases/1/edit
  def edit
    @release = Release.find(params[:id])
  end

  # POST /releases
  # POST /releases.xml
  def create
    @release = Release.new(params[:release])
	@release_to_clone = Release.find(params[:release_to_clone][:id]) unless params[:release_to_clone][:id].blank?
    respond_to do |format|
      if @release.save
		unless @release_to_clone.nil?
			@release.clone_from(@release_to_clone)
		end
        flash[:notice] = 'Release was successfully created.'
        format.html { redirect_to(@release) }
        format.xml  { render :xml => @release, :status => :created, :location => @release }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @release.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /releases/1
  # PUT /releases/1.xml
  def update
    @release = Release.find(params[:id])

    respond_to do |format|
      if @release.update_attributes(params[:release])
        flash[:notice] = 'Release was successfully updated.'
        format.html { redirect_to(@release) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @release.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /releases/1
  # DELETE /releases/1.xml
  def destroy 
    @release = Release.find(params[:id])
    @release.destroy

    respond_to do |format|
      format.htmldef destroy { redirect_to(releases_url) }
      format.xml  { head :ok }
    end
  end
end
