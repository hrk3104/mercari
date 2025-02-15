class CommentsController < ApplicationController
        before_action :authenticate_user!
      
        def create
          item = Item.find(params[:item_id])
          comment = item.comments.build(comment_params) #buildを使い、contentとtweet_idの二つを同時に代入
         comment.user_id = current_user.id
          if comment.save
            flash[:success] = "コメントしました"
            redirect_back(fallback_location: root_path) #直前のページにリダイレクト
          else
            flash[:success] = "コメントできませんでした"
            redirect_back(fallback_location: root_path) #直前のページにリダイレクト
          end
        end
      
        def edit
          @item = Item.find(params[:item_id])
          @comment = @item.comments.find(params[:id])
        end
      
        def update
          comment = Comment.find(params[:id])
          @item = comment.item
          if comment.update(comment_params)
            redirect_to @item
          else
            redirect_to :action => "edit"
          end
        end


        def destroy
          @item = Item.find(params[:item_id])
          comment = @item.comments.find(params[:id])
          comment.destroy
          redirect_back(fallback_location: item_path)
        end

        private
      
          def comment_params
            params.require(:comment).permit(:content)
          end
end
