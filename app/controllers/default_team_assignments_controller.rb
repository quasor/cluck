class DefaultTeamAssignmentsController < ApplicationController
  before_filter :login_required
  # GET /default_team_assignments
  # GET /default_team_assignments.xml
  def index
    @default_team_assignments = DefaultTeamAssignment.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @default_team_assignments }
    end
  end

  # GET /default_team_assignments/1
  # GET /default_team_assignments/1.xml
  def show
    @default_team_assignment = DefaultTeamAssignment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @default_team_assignment }
    end
  end

  # GET /default_team_assignments/new
  # GET /default_team_assignments/new.xml
  def new
    @default_team_assignment = DefaultTeamAssignment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @default_team_assignment }
    end
  end

  # GET /default_team_assignments/1/edit
  def edit
    @default_team_assignment = DefaultTeamAssignment.find(params[:id])
  end

  # POST /default_team_assignments
  # POST /default_team_assignments.xml
  def create
    @default_team_assignment = DefaultTeamAssignment.new(params[:default_team_assignment])

    respond_to do |format|
      if @default_team_assignment.save
        flash[:notice] = 'DefaultTeamAssignment was successfully created.'
        format.html { redirect_to(@default_team_assignment) }
        format.xml  { render :xml => @default_team_assignment, :status => :created, :location => @default_team_assignment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @default_team_assignment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /default_team_assignments/1
  # PUT /default_team_assignments/1.xml
  def update
    @default_team_assignment = DefaultTeamAssignment.find(params[:id])

    respond_to do |format|
      if @default_team_assignment.update_attributes(params[:default_team_assignment])
        flash[:notice] = 'DefaultTeamAssignment was successfully updated.'
        format.html { redirect_to(@default_team_assignment) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @default_team_assignment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /default_team_assignments/1
  # DELETE /default_team_assignments/1.xml
  def destroy
    @default_team_assignment = DefaultTeamAssignment.find(params[:id])
    @default_team_assignment.destroy

    respond_to do |format|
      format.html { redirect_to(default_team_assignments_url) }
      format.xml  { head :ok }
    end
  end
end
