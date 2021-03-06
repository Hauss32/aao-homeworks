const SharedUtil = {
    createTweetElem: (data) => {
        const $tweet = $('<li></li>');

        const $content = $('<p class="content"></p>');
        $content.html(data.content);

        const $mentions = SharedUtil.createMentionsElem(data.mentions);

        const $user = $('<a class="created-by"></a>');
        $user.attr('href', `/users/${data.user.id}`);
        $user.html(data.user.username);

        const $createdTime = $('<time></time>');
        $createdTime.html(data.created_at);
        $createdTime.attr('datetime', data.created_at);

        $tweet.append($content);
        $tweet.append($mentions);
        $tweet.append($user);
        $tweet.append($createdTime);

        return $tweet;
    },

    createMentionsElem: (mentionsJSON) => {
        const $mentions = $('<ul class="mentions"></ul>');

        mentionsJSON.forEach(mention => {
            const $mention = $('<li></li>');
            const $link = $('<a></a>');
            $link.html(mention.user.username);
            $link.attr('href', `users/${mention.user.id}`);

            $mention.append($link);
            $mentions.append($mention);
        })

        return $mentions;
    }
}

module.exports = SharedUtil;