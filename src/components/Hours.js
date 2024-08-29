// PComponente React que muestra las horas de apertura y cierre de un local. Muestra las horas en las que el refugio está abierto durante el día actual. El refugio abre de 10 a.m. a 4 p.m. de lunes a viernes, y de 9 a.m. a 8 p.m. los sábados y domingos.

import React from 'react';  



const Hours = () => {

    const hours = {
        0: 'Domingos: 9 a.m. - 8 p.m.',
        1: 'Lunes: 10 a.m. - 4 p.m.',
        2: 'Martes: 10 a.m. - 4 p.m.',
        3: 'Miercoles: 10 a.m. - 4 p.m.',
        4: 'Jueves: 10 a.m. - 4 p.m.',
        5: 'Viernes: 10 a.m. - 4 p.m.',
        6: 'Sabados: 9 a.m. - 8 p.m.'
    };
        

  const today = new Date().getDay();
  const todayHours = hours[today];
  
  return (
    <div>
      <h2>Nuestro Horario:</h2>
      <p>{todayHours}</p>
    </div>
  );
}

export default Hours;