
class Comment {
  int? commentid;
  int? weiboid;
  int? fromuid;
  String? fromuname;
  String? fromhead;
  int? fromuserismember;
  int? fromuserisvertify;
  String? content;
  int? createtime;
  List<CommentReply>? commentreply;
  int? commentreplynum;

  //是否已经展开
  bool isHasOpen = false;


  Comment(
      {this.commentid,
        this.weiboid,
        this.fromuid,
        this.fromuname,
        this.fromhead,
        this.fromuserismember,
        this.fromuserisvertify,
        this.content,
        this.createtime,
        this.commentreply,
        this.commentreplynum,

      });

  Comment.fromJson(Map<String, dynamic> json) {
    commentid = json['commentid'];
    weiboid = json['weiboid'];
    fromuid = json['fromuid'];
    fromuname = json['fromuname'];
    fromhead = json['fromhead'];
    fromuserismember = json['fromuserismember'];
    fromuserisvertify = json['fromuserisvertify'];
    content = json['content'];
    createtime = json['createtime'];
    if (json['commentreply'] != null) {
      commentreply = <CommentReply>[];
      json['commentreply'].forEach((v) {
        commentreply?.add(CommentReply.fromJson(v));
      });
    }
    commentreplynum = json['commentreplynum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['commentid'] = this.commentid;
    data['weiboid'] = this.weiboid;
    data['fromuid'] = this.fromuid;
    data['fromuname'] = this.fromuname;
    data['fromhead'] = this.fromhead;
    data['fromuserismember'] = this.fromuserismember;
    data['fromuserisvertify'] = this.fromuserisvertify;
    data['content'] = this.content;
    data['createtime'] = this.createtime;
    if (this.commentreply != null) {
      data['commentreply'] = this.commentreply?.map((v) => v.toJson()).toList();
    }
    data['commentreplynum'] = this.commentreplynum;
    return data;
  }
}

class CommentReply {
  int? commentId;
  int? crId;
  int? fromuId;
  String? fromuName;
  String? fromHead;
  int? fromUserIsMember;
  int? fromUserIsVertify;
  String? content;
  int? createTime;

  CommentReply(
      {this.commentId,
        this.crId,
        this.fromuId,
        this.fromuName,
        this.fromHead,
        this.fromUserIsMember,
        this.fromUserIsVertify,
        this.content,
        this.createTime});

  CommentReply.fromJson(Map<String, dynamic> json) {
    commentId = json['commentid'];
    crId = json['crid'];
    fromuId = json['fromuid'];
    fromuName = json['fromuname'];
    fromHead = json['fromhead'];
    fromUserIsMember = json['fromuserismember'];
    fromUserIsVertify = json['fromuserisvertify'];
    content = json['content'];
    createTime = json['createtime'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['commentid'] = commentId;
    data['crid'] = crId;
    data['fromuid'] = fromuId;
    data['fromuname'] = fromuName;
    data['fromhead'] = fromHead;
    data['fromuserismember'] = fromUserIsMember;
    data['fromuserisvertify'] = fromUserIsVertify;
    data['content'] = content;
    data['createtime'] = createTime;
    return data;
  }
}