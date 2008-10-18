class TeamAssignmentsController < ApplicationController
  before_filter :login_required, :except => [:update]
  
  #  GET /team_assignments
  # GET /team_assignments.xml
  def index
	@release = Release.find(params[:release_id]) unless params[:release_id].blank?
    @team_assignments = Event.find(:all, :order => :updated_at, :conditions => {:release_id => @release})

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @team_assignments }
    end
  end

  # GET /team_assignments/1
  # GET /team_assignments/1.xml
  def show
    @team_assignment = TeamAssignment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @team_assignment }
    end
  end

  # GET /team_assignments/new
  # GET /team_assignments/new.xml
  def new
    @team_assignment = TeamAssignment.new
	@cluster = Cluster.find(params[:cluster_id])
	@team_assignment.cluster = @cluster
	@team_assignment.release = @cluster.release
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @team_assignment }
    end
  end

  # GET /team_assignments/1/edit
  def edit
    @team_assignment = TeamAssignment.find(params[:id])
  end

  # POST /team_assignments
  # POST /team_assignments.xml
  def create
    @team_assignment = TeamAssignment.new(params[:team_assignment])

    respond_to do |format|
      if @team_assignment.save
        flash[:notice] = 'TeamAssignment was successfully created.'
        format.html { redirect_to(@team_assignment.cluster) }
        format.xml  { render :xml => @team_assignment, :status => :created, :location => @team_assignment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @team_assignment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /team_assignments/1
  # PUT /team_assignments/1.xml
  def update
    @team_assignment = TeamAssignment.find(params[:id])
	@team_assignment.updated_by = current_user
    respond_to do |format|
      if @team_assignment.update_attributes(params[:team_assignment])
        flash[:notice] = 'TeamAssignment was successfully updated.'
        format.html { redirect_to(release_team_path(@team_assignment.cluster.release,@team_assignment.team)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @team_assignment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /team_assignments/1
  # DELETE /team_assignments/1.xml
  def destroy
    @team_assignment = TeamAssignment.find(params[:id])
    @cluster = @team_assignment.cluster
    @team_assignment.destroy

    respond_to do |format|
      format.html { redirect_to(@cluster) }
      format.xml  { head :ok }
    end
  end
end
