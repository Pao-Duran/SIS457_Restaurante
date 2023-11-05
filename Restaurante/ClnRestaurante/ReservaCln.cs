using CadRestaurante;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClnRestaurante
{
    public class ReservaCln
    {
        public static int insertar(Reserva reserva)
        {
            using (var context = new RestauranteEntities())
            {
                context.Reserva.Add(reserva);
                context.SaveChanges();
                return reserva.id;
            }
        }

        public static int actualizar(Reserva reserva)
        {
            using (var context = new RestauranteEntities())
            {
                var existente = context.Reserva.Find(reserva.id);
                existente.idCliente = reserva.idCliente;
                existente.fechaReserva = reserva.fechaReserva;
                existente.idMesa = reserva.idMesa;
                existente.usuarioRegistro = reserva.usuarioRegistro;
                return context.SaveChanges();
            }
        }

        public static int eliminar(int id, string usuarioRegistro)
        {
            using (var context = new RestauranteEntities())
            {
                var existente = context.Reserva.Find(id);
                existente.estado = -1;
                existente.usuarioRegistro = usuarioRegistro;
                return context.SaveChanges();
            }
        }

        public static Reserva get(int id)
        {
            using (var context = new RestauranteEntities())
            {
                return context.Reserva.Find(id);
            }
        }

        public static List<Reserva> listar()
        {
            using (var context = new RestauranteEntities())
            {
                return context.Reserva.Where(x => x.estado != -1).ToList();
            }
        }

        public static List<paReservaListar_Result> listarPa(string parametro)
        {
            using (var context = new RestauranteEntities())
            {
                return context.paReservaListar(parametro).ToList();
            }
        }
    }
}
