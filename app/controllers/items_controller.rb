class ItemsController < ApplicationController
  before_action :authenticate_user!

    def index
        @items = Item.all
        @q = Item.ransack(params[:q]) 
        @items= @q.result
        @users = User.all
    end

    def new
        @item = Item.new
    end

    def create
        item = Item.new(item_params)

        item.user_id = current_user.id 

        if item.save
          redirect_to :action => "index"
        else
          redirect_to :action => "new"
        end
      end


      def show
        @item = Item.find(params[:id])
        @comments = @item.comments
        @comment = Comment.new
      end

      def edit
        @item = Item.find(params[:id])
      end
    
      def update
        item = Item.find(params[:id])
        if item.update(item_params)
          redirect_to :action => "show", :id => item.id
        else
          redirect_to :action => "new"
        end
      end

      def upload_image
        @image_blob = create_blob(params[:image])
        render json: @image_blob
      end


      def destroy
        item = Item.find(params[:id])
        item.destroy
        redirect_to action: :index
      end


      private
      def set_item
        @item = Item.find(params[:id])
      end

      def uploaded_images
        params[:item][:images].drop(1).map{|id| ActiveStorage::Blob.find(id)} if params[:post][:images]
      end

      def create_blob(file)
        ActiveStorage::Blob.create_and_upload!(
          io: file.open,
          filename: file.original_filename,
          content_type: file.content_type
        )
      end

      def item_params
        params.require(:item).permit(:price, :about, :title, :images).merge(images: uploaded_images)
      end

end
