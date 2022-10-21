window.addEventListener('message', function(event) {
    var item = event.data;
    if(item.action == 'InSideMenu') {
        if(item.status == true) { 
            $('.content').fadeIn(); 
            $('.head-txt').text(item.servername)

            document.onkeyup = function(data) { 
                if (data.which == 27) {  
                    close() 
                    $(".app__bg").empty()
                }  
            };
        } else { 
            close();
            $(".app__bg").empty()
        }
    }else if(item.type == 'add') {
        newAd(item.name, item.msg)
    }  
})

  
function SendAd() {
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
 
function newAd(name, msg) { 
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