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
    }
};

module.exports = APIUtil;