1. 优化
	DELETE FROM wp_comments WHERE comment_approved != '1';
	DELETE FROM wp_postmeta WHERE meta_key = '_edit_lock';
	DELETE FROM wp_postmeta WHERE meta_key = '_edit_last';

	DELETE pm FROM wp_postmeta pm LEFT JOIN wp_posts wp ON wp.ID = pm.post_id WHERE wp.ID IS NULL;


	DELETE FROM wp_postmeta WHERE meta_key = '_wp_old_slug';
	DELETE FROM wp_postmeta WHERE meta_key = '_revision-control';
	DELETE FROM wp_postmeta WHERE meta_value = '{{unknown}}';


	删除日志修订版本
	DELETE a,b,c FROM wp_posts a  LEFT JOIN wp_term_relationships b ON (a.ID = b.object_id) LEFT JOIN wp_postmeta c ON (a.ID = c.post_id) WHERE a.post_type = 'revision'




2. 