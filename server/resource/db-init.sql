create table if not exists tb_pedido (
  id integer not null primary key autoincrement,
  dt_pedido timestamp not null,
  dt_entrega timestamp,
  nr_tempopedido integer not null,
  vl_pedido decimal(9,2) not null,
  cd_cliente integer not null
);

create table if not exists tb_cliente (
  id integer not null primary key autoincrement,
  nr_documento varchar(15) not null
);


create view if not exists V_pedidos as
select
	c.nr_documento as documento,
	c.id as cliente_codigo,
	c.nome as cliente_nome,
	p.id as pedido_id,
	p.nr_tempopedido as pedido_tempo,
	p.vl_pedido as pedido_valor,
	p.dt_pedido as pedido_data,
	case p.tamanho
		when '0' then
			'pequena'
		when '1' then
		 'media'
		when '2' then
			'grande'
	else
		'indefinido'
	end as tamanho,
	case p.sabor
		when '0' then
			'enCalabresa'
		when '1' then
			'enMarguerita'
		when '2' then
			'enPortuguesa'
		else
			'Sem sabor definido'
		end as sabor
from
	tb_pedido as p
	left join tb_cliente c on c.id = p.cd_cliente
order by
	p.dt_pedido asc;
