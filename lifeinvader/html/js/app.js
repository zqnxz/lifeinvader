window.addEventListener('message', function(e) {
    var e = e.data;
    switch(e.action) {
        case 'InSideMenu':
            switch(e.status) {
                case true:
                    $('.content').fadeIn(); 
                    $('.head-txt').text(item.servername)

                    document.onkeyup = function(data) { 
                        if (data.which == 27) {  
                            close() 
                            $(".app__bg").empty()
                        }  
                    };
                    break;
                case false: 
                    close();
                    $(".app__bg").empty()
                    break;
            }
            break; 
        case 'add': 
            newAd(e.name, e.msg);
            break; 
    } 
})

  
const SendAd = () => {
    let werbemsg = $('#text__field').val()
    if(!werbemsg) { 
        $.post('https://lifeinvader/Message__Error', JSON.stringify({}))
    } else {
        //double check 
        if($("#anonym").is(':checked') && $('#normal').is(':checked')) {
            $.post('https://lifeinvader/checked__error', JSON.stringify({})) 
        } else {
            if($("#anonym").is(':checked')) {
                $.post('https://lifeinvader/anonym', JSON.stringify({
                    text: $('#text__field').val(),
                })) 
            }  
            
            if($("#normal").is(':checked')) {
                $.post('https://lifeinvader/normal', JSON.stringify({
                    text: $('#text__field').val(),
                })) 
            }    
        }     
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

function close() {
    $.post('https://lifeinvader/close', JSON.stringify({}))
    $('.content').fadeOut();
    return 
}
 
$('.btn-werbung').click(function() {
    $('.box').hide()
    $('.werbung__box').show()
})

$('.btn-create').click(function() {
    $('.box').show() 
    $('.werbung__box').hide()
})