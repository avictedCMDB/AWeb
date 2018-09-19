(function ($) {
    'use strict';

    $.fn.myTree = function (options) {
        //合并默认参数和用户传过来的参数
        options = $.extend({}, $.fn.myTree.defaults, options || {});

        var that = $(this);
        var strHtml = "";
        //如果用户传了data的值，则直接使用data，否则发送ajax请求去取data
        if (options.data) {
            strHtml = initTree(options.data);
            that.html(strHtml);
            initClickNode();
        }
        else {
            //在发送请求之前执行事件
            options.onBeforeLoad.call(that, options.param);
            if (!options.url)
                return;
            //发送远程请求获得data
            $.getJSON(options.url, options.param, function (data) {
                strHtml = initTree(data);
                that.html(strHtml);
                initClickNode();

                //请求完成之后执行事件
                options.onLoadSuccess.call(that, data);
            });
        }

        //注册节点的点击事件
        function initClickNode() {
            $('.tree li').addClass('parent_li').find(' > span').attr('title', '收起');
            $('.tree li.parent_li > span').on('click', function (e) {
                var children = $(this).parent('li.parent_li').find(' > ul > li');
                if (children.is(":visible")) {
                    children.hide('fast');
                    $(this).attr('title', '展开').find(' > i').addClass('icon-plus-sign').removeClass('icon-minus-sign');
                } else {
                    children.show('fast');
                    $(this).attr('title', '收起').find(' > i').addClass('icon-minus-sign').removeClass('icon-plus-sign');
                }

                $('.tree li[class="parent_li"]').find("span").css("background-color", "transparent");
//                $(this).css("background-color", "#428bca");

                options.onClickNode.call($(this), $(this));
            });
        };

        //递归拼接html构造树形子节点
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
                    <span class="node-text">市场部</span>
                  </div>                    
                </label>
              </li>*/
              strHtml += "<li class='tree-node' id=\"li_" + data[i].id + "\"><span id=\"span_" + data[i].id +"\"class=\"" + strTextStyle+ "\"><i class=\"" + strIconStyle + "\"></i>" + data[i].companyName +  "</span>" + strHtmlUL + "</li>";

            }
            return strHtml;
        };
    };

    //默认参数
    $.fn.myTree.defaults = {
        url: null,
        param: null,
        data: null,
        onBeforeLoad: function (param) { },
        onLoadSuccess: function (data) { },
        onClickNode: function (selector) { }
    };

})(jQuery);