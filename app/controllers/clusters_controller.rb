class ClustersController < ApplicationController
  before_filter :login_required
   # GET /clusters
  # GET /clusters.xml
  def index
    @clusters = Cluster.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @clusters }
    end
  end

  # GET /clusters/1
  # GET /clusters/1.xml
  def show
    @cluster = Cluster.find(params[:id])
	
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cluster }
    end
  end

  # GET /clusters/new
  # GET /clusters/new.xml
  def new
    @cluster = Cluster.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cluster }
    end
  end

  # GET /clusters/1/edit
  def edit
    @cluster = Cluster.find(params[:id])
  end

  # POST /clusters
  # POST /clusters.xml
  def create
    @cluster = Cluster.new(params[:cluster])

    respond_to do |format|
      if @cluster.save
        flash[:notice] = 'Cluster was successfully created.'
        format.html { redirect_to(@cluster) }
        format.xml  { render :xml => @cluster, :status => :created, :location => @cluster }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cluster.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /clusters/1
  # PUT /clusters/1.xml
  def update
    @cluster = Cluster.find(params[:id])
	@state_id = @cluster.state_id
	action = @cluster.state.name
    respond_to do |format|
      if @cluster.update_attributes(params[:cluster])
	  	Event.create(
		:release_id => @cluster.release.id,
		:state_id => @state_id,
		:action => @cluster.reload.state.name,
		:cluster_id => @cluster.id, 
		:updated_by => current_user)

		flash[:notice] = 'Cluster was successfully updated.'
        format.html { redirect_to(@cluster) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cluster.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /clusters/1
  # DELETE /clusters/1.xml
  def destroy
    @cluster = Cluster.find(params[:id])
    @cluster.destroy

    respond_to do |format|
      format.html { redirect_to(clusters_url) }
      format.xml  { head :ok }
    end
  end
end
