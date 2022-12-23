$(document).ready(async () => {
    window.addEventListener('message', function (event) {
        var data = event.data;
        switch (data.action) {
            case 'InSideMenu':
                switch (data.status) { 
                    case true:
                        $('.content').fadeIn();
                        $('.head-txt').text(data.servername);
                        escClose();
                        break;  
                    case false:
                        close();
                        break;
                }  
                break;
            case 'add':
                newAd(data.name, data.msg);
                break;
        }
        $('.btn-werbung').click(() => {
            $('.box').hide() 
            $('.werbung__box').show()
        })

        $('.btn-create').click(() => { 
            $('.box').show()
            $('.werbung__box').hide()
        })
    });
});

const escClose = () => {
    document.onkeyup = (data) => {
        switch(data.which) {
            case 27:
                close();
                break;
        }
    }
}


const SendAd = () => {
    let werbemsg = $('#text__field').val()
    if (!werbemsg) {
        return $.post('https://lifeinvader/Message__Error', JSON.stringify({}))
    }
    //double check 
    if ($("#anonym").is(':checked') && $('#normal').is(':checked')) {
        return $.post('https://lifeinvader/checked__error', JSON.stringify({}))
    }
    if ($("#anonym").is(':checked')) {
        $.post('https://lifeinvader/anonym', JSON.stringify({
            text: $('#text__field').val(),
        })) 
    }

    if ($("#normal").is(':checked')) {
        $.post('https://lifeinvader/normal', JSON.stringify({
            text: $('#text__field').val(),
        }))
    }
}


const newAd = (name, msg) => {
    $('.app__bg').append(` 
        <div class="inner">    
            <span class="name">${name}</span>
            <span class="msg">${msg}</span>
        </div>
    `)
}
 
const close = () => {
    $.post('https://lifeinvader/close', JSON.stringify({}))
    $('.content').fadeOut();
    return
}

 