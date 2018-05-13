.pragma library
var mask = new Array;
mask[0] = 0x10;//16
mask[1] = 0x11;
mask[2] = 0x3;
var mingWen=new String;

var count = mask.length/mask[0].length;

 function decode(passWord){
    var chart=new Array;
    var index=0;
    var len=passWord.length
       for(var i=1;i<len-1;i++,index++)
       {
            var c=passWord.charCodeAt(i);
            var j=index%3;
            chart.push(String.fromCharCode(c ^ mask[j]));

        }
      mingWen=chart.join("");
      return  mingWen;
}
function encode(passWord){
    var chart=new Array;
    var index=0;
    var len=passWord.length;
    //chart.push('<');
    for(var i=0;i<len;i++){
         var c=passWord.charCodeAt(i);

         var j=index%3;
        chart.push(String.fromCharCode(c ^ mask[j]));
    }
    // chart.push('>');
     mingWen=chart.join("");
      return  mingWen;
}
