const Body = () => {
  const columns = [
    {
      img: " https://plus.unsplash.com/premium_photo-1691735666207-be6e91326e3a?q=80&w=2076&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      title: "Poon Hill, Nepal",
      description: "Image by Sylwia Bartyzel",
    },
    {
      img: "https://plus.unsplash.com/premium_photo-1691735665916-cf31006dffe3?q=80&w=2076&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      title: " Swambhu Nepal",
      description: "This is a temple from Kathmandu Nepal  ",
    },
    {
      title: "Pokhara, Nepal",
      description: "A famous late from Pokhara Nepal",
      img: "https://images.unsplash.com/photo-1562462181-b228e3cff9ad?q=80&w=2020&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    },
  ];

  return (
    <section id="three-column" className="py-5 bg-light">
      <div className="container">
        <div className="row text-center">
          {columns.map((column, index) => (
            <div key={index} className="col-md-4 mb-4">
              <img
                src={column.img}
                alt={column.title}
                className="img-fluid rounded mb-3"
              />
              <h3>{column.title}</h3>
              <p>{column.description}</p>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
};

export default Body;
