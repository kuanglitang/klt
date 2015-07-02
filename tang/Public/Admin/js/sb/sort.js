$(function(){
    //�������
    sort();
    $(".top").click(function(){
        rest();
        $("option:selected").prependTo("select");
        sort();
    })
    $(".bottom").click(function(){
        rest();
        $("option:selected").appendTo("select");
        sort();
    })
    $(".up").click(function(){
        rest();
        $("option:selected").after($("option:selected").prev());
        sort();
    })
    $(".down").click(function(){
        rest();
        $("option:selected").before($("option:selected").next());
        sort();
    })
    $(".search").click(function(){
        var v = $("input").val();
        $("option:contains("+v+")").attr('selected','selected');
    })
    function sort(){
        $('option').text(function(){return ($(this).index()+1)+'.'+$(this).text()});
    }

    //��������option���֡�
    function rest(){
        $('option').text(function(){
            return $(this).text().split('.')[1]
        });
    }

    //��ȡ�����ύ
    $('.sort_confirm').click(function(){
        var arr = new Array();
        $('.ids').each(function(){
            arr.push($(this).val());
        });
        $('input[name=ids]').val(arr.join(','));
        $.post(
            $('form').attr('action'),
            {
            'ids' :  arr.join(',')
            },
            function(data){
                if (data.status) {
                    updateAlert(data.info + ' ҳ�漴���Զ���ת~','alert-success');
                }else{
                    updateAlert(data.info,'alert-success');
                }
                setTimeout(function(){
                    if (data.status) {
                        $('.sort_cancel').click();
                    }
                },1500);
            },
            'json'
        );
    });

    //���ȡ����ť
    $('.sort_cancel').click(function(){
        window.location.href = $(this).attr('url');
    });
})