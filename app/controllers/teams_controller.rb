class TeamsController < ApplicationController
  before_filter :login_required, :except => [:show]
  # GET /teams
  # GET /teams.xml
  def index
    @teams = Team.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @teams }
    end
  end

  # GET /teams/1
  # GET /teams/1.xml
  def show
    @team = Team.find(params[:id])
	  if params[:release_id].nil?
		  return redirect_to(releases_path)
	  end
    @release = Release.find(params[:release_id])
  	@clusters = @team.clusters.find_all_by_release_id(@release.id)
  	@team_assignments = @clusters.collect { |cluster| cluster.team_assignments.find(:all, :conditions => {:team_id => @team.id, :state_id => cluster.state_id}) }.flatten.uniq
  	@team_assignments = TeamAssignment.find(:all,:conditions => {:id => @team_assignments.collect(&:id)}, :include => {:cluster => :state }, :order => 'states.sequence_number, clusters.updated_at')

		@types = @clusters.collect(&:type).flatten.uniq		
		
		if !@types.empty? && params[:t].blank?
			@type = @types.first.to_s
			return redirect_to release_team_path(:t => @type.to_s)
		else
			@type = params[:t]
		end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @team }
    end
  end

  # GET /teams/new
  # GET /teams/new.xml
  def new
    @team = Team.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @team }
    end
  end

  # GET /teams/1/edit
  def edit
    @team = Team.find(params[:id])
  end

  # POST /teams
  # POST /teams.xml
  def create
    @team = Team.new(params[:team])

    respond_to do |format|
      if @team.save
        flash[:notice] = 'Team was successfully created.'
        format.html { redirect_to(@team) }
        format.xml  { render :xml => @team, :status => :created, :location => @team }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @team.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /teams/1
  # PUT /teams/1.xml
  def update
    @team = Team.find(params[:id])
    @release = Release.find(params[:release_id]) unless params[:release_id].blank?
	  @clusters = @team.clusters.find_all_by_release_id(@release.id) unless params[:release_id].blank?
	  @team_assignments = @clusters.collect { |cluster| cluster.team_assignments.find(:all, :conditions => {:team_id => @team.id, :state_id => cluster.state_id}) }.flatten.uniq unless params[:release_id].blank?
	  @clusters.each do |c|
			unless params[:cluster][c.id.to_s].nil?
				unless params[:cluster][c.id.to_s][:body].blank?
					c.notes << Note.create(:body => params[:cluster][c.id.to_s][:body], :created_by => current_user)
				end
			end 
		end unless params[:release_id].blank?
	
	
  	@team.attributes = params[:team] if admin?
  	@team_assignments.each do |t| 
  		t.attributes = params[:team_assignment][t.id.to_s] if params[:team_assignment][t.id.to_s] 
  		t.valid?
  	end unless params[:release_id].blank?
    respond_to do |format|
      if @team.valid? && (@team_assignments.nil? || @team_assignments.all?(&:valid?))
    		@team.save! if admin?
    		@team_assignments.each do |ta|
    			ta.updated_by = current_user
    			ta.auto_promote = true
    			ta.save!
    		end unless params[:release_id].blank?
        flash[:notice] = 'Team was successfully updated.'
        format.html { redirect_to @release.nil? ? teams_path : release_team_path(@release,@team) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @team.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.xml
  def destroy
    @team = Team.find(params[:id])
    @team.destroy

    respond_to do |format|
      format.html { redirect_to(teams_url) }
      format.xml  { head :ok }
    end
  end
end
