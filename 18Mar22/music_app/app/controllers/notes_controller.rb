class NotesController < ApplicationController
    def create
        @note = Note.new(note_params)
        @note.user_id = current_user.id

        unless @note.save
            flash[:note] = @note.errors.full_messages
            flash[:note_body] = @note.body
        end

        redirect_to track_url(@note.track_id)
    end

    def destroy
        note = Note.find_by_id(params[:id])

        if note.user_id == current_user.id
            track_id = note.track_id
            note.destroy
            redirect_to track_url(track_id)
        else
            render json: "You must own this note to delete it.", status: :forbidden
        end
    end

    private
    def note_params
        params[:note].permit(:body, :track_id)
    end
end