(function ($) {
    'use strict';

    $.fn.myTree = function (options) {
        //�ϲ�Ĭ�ϲ������û��������Ĳ���
        options = $.extend({}, $.fn.myTree.defaults, options || {});

        var that = $(this);
        var strHtml = "";
        //����û�����data��ֵ����ֱ��ʹ��data��������ajax����ȥȡdata
        if (options.data) {
            strHtml = initTree(options.data);
            that.html(strHtml);
            initClickNode();
        }
        else {
            //�ڷ�������֮ǰִ���¼�
            options.onBeforeLoad.call(that, options.param);
            if (!options.url)
                return;
            //����Զ��������data
            $.getJSON(options.url, options.param, function (data) {
                strHtml = initTree(data);
                that.html(strHtml);
                initClickNode();

                //�������֮��ִ���¼�
                options.onLoadSuccess.call(that, data);
            });
        }

        //ע��ڵ�ĵ���¼�
        function initClickNode() {
            $('.tree li').addClass('parent_li').find(' > span').attr('title', '����');
            $('.tree li.parent_li > span').on('click', function (e) {
                var children = $(this).parent('li.parent_li').find(' > ul > li');
                if (children.is(":visible")) {
                    children.hide('fast');
                    $(this).attr('title', 'չ��').find(' > i').addClass('icon-plus-sign').removeClass('icon-minus-sign');
                } else {
                    children.show('fast');
                    $(this).attr('title', '����').find(' > i').addClass('icon-minus-sign').removeClass('icon-plus-sign');
                }

                $('.tree li[class="parent_li"]').find("span").css("background-color", "transparent");
//                $(this).css("background-color", "#428bca");

                options.onClickNode.call($(this), $(this));
            });
        };

        //�ݹ�ƴ��html���������ӽڵ�
        function initTree(data) {
            var strHtml = "";
            for (var i = 0; i < data.length; i++) {
                var arrChild = data[i].childDepartments;
                var strHtmlUL = "";
                var strIconStyle = "node-icon icon-allot";
                var strTextStyle = "node-text node-title";
                var stylei = "<i class='node-icon icon-expand'></i>";
                if (arrChild && arrChild.length > 0) {
                    strHtmlUL = "<ul>";
                    strHtmlUL += initTree(arrChild) + "</ul>";
                    strIconStyle = "node-icon icon-file";
                    strTextStyle = "node-text";
                    stylei = "<i class='node-icon icon-elbow-line'></i>";
                }
               /* <li class="tree-node">
                <label>
                  <input class="node-check" type="checkbox">
                  <div class="node-content">
                    <i class="node-icon icon-elbow-line"></i>
                    <i class="node-icon icon-elbow"></i>
                    
                    <i class="node-icon icon-file"></i>
                    <span class="node-text">�г���</span>
                  </div>                    
                </label>
              </li>*/
              strHtml += "<li class='tree-node' id=\"li_" + data[i].id + "\"><span id=\"span_" + data[i].id +"\"class=\"" + strTextStyle+ "\"><i class=\"" + strIconStyle + "\"></i>" + data[i].companyName +  "</span>" + strHtmlUL + "</li>";

            }
            return strHtml;
        };
    };

    //Ĭ�ϲ���
    $.fn.myTree.defaults = {
        url: null,
        param: null,
        data: null,
        onBeforeLoad: function (param) { },
        onLoadSuccess: function (data) { },
        onClickNode: function (selector) { }
    };

})(jQuery);