create or replace procedure agregar_articulo_json(p_json_articulo varchar2) is

j_articulo json_object_t;
v_nombre varchar2(20);
v_descripcion articulos.descripcion%type;
v_precio articulos.precio%type;
v_id_articulo articulos.idarticulo%type;

begin 

    j_articulo := json_object_t(p_json_articulo);

    v_nombre := j_articulo.get_string('nombre');
    v_descripcion := j_articulo.get_string('descripcion');
    v_precio := j_articulo.get_number('precio');

    select max(idarticulo)+1
    into v_id_articulo
    from articulos;

    insert into articulos (idarticulo,nombre,descripcion,precio)
    values(v_id_articulo,v_nombre,v_descripcion,v_precio);

    exception when others then
     dbms_output.put_line(sqlcode||' - '||sqlerrm);

end;