class CertsController < ApplicationController
  # GET /certs
  # GET /certs.json
  def index
    @certs = Cert.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @certs }
    end
  end

  # GET /certs/1
  # GET /certs/1.json
  def show
    @cert = Cert.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @cert }
    end
  end

  # GET /certs/new
  # GET /certs/new.json
  def new
    @cert = Cert.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @cert }
    end
  end

  # GET /certs/1/edit
  def edit
    @cert = Cert.find(params[:id])
  end

  # POST /certs
  # POST /certs.json
  def create
    @cert = Cert.new(params[:cert])

    respond_to do |format|
      if @cert.save
        format.html { redirect_to @cert, :notice => 'Cert was successfully created.' }
        format.json { render :json => @cert, :status => :created, :location => @cert }
      else
        format.html { render :action => "new" }
        format.json { render :json => @cert.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /certs/1
  # PUT /certs/1.json
  def update
    @cert = Cert.find(params[:id])

    respond_to do |format|
      if @cert.update_attributes(params[:cert])
        format.html { redirect_to @cert, :notice => 'Cert was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @cert.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /certs/1
  # DELETE /certs/1.json
  def destroy
    @cert = Cert.find(params[:id])
    @cert.destroy

    respond_to do |format|
      format.html { redirect_to certs_url }
      format.json { head :no_content }
    end
  end
end
