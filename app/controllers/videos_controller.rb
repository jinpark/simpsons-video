class VideosController < ApplicationController
    before_action :set_video, only: [:show, :edit, :update, :destroy]

    # GET /videos
    # GET /videos.json
    def index
        @videos = Video.all
    end

    # GET /videos/1
    # GET /videos/1.json
    def show
        if !cookies[:random_list]
            cookies[:random_list] = ActiveSupport::JSON.encode(Video.random(Video.count).pluck('id'))
        end
        random_list = ActiveSupport::JSON.decode(cookies[:random_list])
        episode_index = random_list.index(params[:id].to_i)
        cookies[:episode_index] = episode_index
        @prev_video = Video.find_by_id(random_list[episode_index - 1])
        @next_video = Video.find_by_id(random_list[episode_index + 1])
        @next_next_video = Video.find_by_id(random_list[episode_index + 2])

    end

    def get_new_random
        if !cookies[:random_list]
            @random_list = ActiveSupport::JSON.encode(Video.random(Video.count).pluck('id'))
        else
            @random_list = ActiveSupport::JSON.decode(cookies[:random_list])
        end
        if cookies[:episode_index]
            episode_index = cookies[:episode_index].to_i
            watched = @random_list[0..episode_index]
            remaining = @random_list[episode_index + 1..-1]
            remaining = remaining.shuffle
            @random_list = watched + remaining
        end
        @random_list
    end

    def history
        if !cookies[:random_list]
            random_ids = Video.random(Video.count).pluck('id')
            random_list = ActiveSupport::JSON.encode(random_ids)
            cookies[:random_list] = random_list
        else
            random_ids = ActiveSupport::JSON.decode(cookies[:random_list])
        end
        random_list_unsorted_videos = Video.find(random_ids)
        random_list_sorted_videos = random_ids.collect {|id| random_list_unsorted_videos.detect {|x| x.id == id}}
        if cookies[:episode_index]
            episode_index = cookies[:episode_index].to_i
            watched = random_ids[0..episode_index]
            remaining = random_ids[episode_index + 1..-1]
        else
            episode_index = 0
            watched = [random_ids.first]
            remaining = random_ids[1..-1]
        end

        random_list_sorted_videos_hash = random_list_sorted_videos.as_json
        watched.map{ |n| random_list_sorted_videos_hash[n]['watched'] = true }
        @random_list_sorted_videos_json = random_list_sorted_videos_hash.to_json

    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_video
            if params[:id]
                @video = Video.find(params[:id])
            end
            if params[:season] && params[:episode_number]
                season = params[:season].to_i
                episode_number = params[:episode_number].to_i
                @video = Video.find_by_season_and_episode_number(season, episode_number)
                params[:id] = @video.id
            end
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def video_params
            params.require(:video).permit(:title, :season, :episode_number, :thumbnail, :path, :filename)
        end
end
