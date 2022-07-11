const APIUtil = {
    followUser: id => {
        return $.ajax({
            url: `/users/${id}/follow`,
            type: 'POST',
            dataType: 'json'
        });
    },

    unfollowUser: id => {
        return $.ajax({
            url: `/users/${id}/follow`,
            type: 'DELETE',
            dataType: 'json'
        });
    },

    searchUsers: queryStr => {
        return $.ajax({
            url: `/users/search`,
            type: 'GET',
            dataType: 'json',
            data: {
                query: queryStr
            }
        });
    },

    composeTweet: (json) => {
        return $.ajax({
            url: `/tweets`,
            type: 'POST',
            dataType: 'json',
            data: json
        });
    },

    fetchTweets: createdAtFilter => {
        return $.ajax({
            url: `/feed`,
            type: 'GET',
            dataType: 'json',
            data: {
                max_created_at: createdAtFilter
            }
        });
    }

};

module.exports = APIUtil;